Return-Path: <linux-kernel-owner+w=401wt.eu-S1751970AbWLNTX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbWLNTX6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWLNTX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:23:58 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:41864 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751970AbWLNTX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:23:58 -0500
Message-ID: <4581A4A1.4050707@scientia.net>
Date: Thu, 14 Dec 2006 20:23:13 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: andersen@codepoet.org, Karsten Weiss <K.Weiss@science-computing.de>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org> <45808DC3.2010907@scientia.net> <20061214092431.GD6674@rhun.haifa.ibm.com>
In-Reply-To: <20061214092431.GD6674@rhun.haifa.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060802050209020503080409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802050209020503080409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Muli Ben-Yehuda wrote:
>> 4)
>> And does someone know if the nforce/opteron iommu requires IBM Calgary
>> IOMMU support?
>>     
> It doesn't, Calgary isn't found in machine with Opteron CPUs or NForce
> chipsets (AFAIK). However, compiling Calgary in should make no
> difference, as we detect in run-time which IOMMU is found and the
> machine.
Yes,.. I've read the relevant section shortly after sending that email ;-)

btw & for everybody:
I'm working (as student) at the LRZ (Leibniz Computing Centre) in Munich
where we have very large Linux Cluster and lots of different other
machines,...
I'm going to test for that error on most of the different types of
systems we have,.. and will inform you about my results (if they're
interesting).

Chris.

--------------060802050209020503080409
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------060802050209020503080409--
