Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWLBB2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWLBB2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 20:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759366AbWLBB2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 20:28:15 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:50066 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1759365AbWLBB2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 20:28:14 -0500
Message-ID: <4570D6AB.9010204@scientia.net>
Date: Sat, 02 Dec 2006 02:28:11 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061124)
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net> <20061202011505.GA2728@codepoet.org>
In-Reply-To: <20061202011505.GA2728@codepoet.org>
Content-Type: multipart/mixed;
 boundary="------------030608070506090808060001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030608070506090808060001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Erik Andersen wrote:
> Doh!  I have a Tyan S2895 in my system, and I've been pulling my
> hair out trying to track down the cause of a similar somewhat
> rare failure for the pre-computer sha1 of a block of data to
> actually match the calculated sha1.  I'd been hunting in vain the
> past few days trying to find a cause -- looking for buffer
> overflows, non thread safe code, or similar usual suspects.
>
> It is a relief to see I am not alone!
>   
^^

You might read my email and all links in it, etc. throughly,.. than you
can try what I did.

Please inform me about all your results, and about your specific
hardware (i.e. CPU type (with stepping and exact model), which harddisks
and so on).

Best wishes,
Chris.

--------------030608070506090808060001
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030608070506090808060001--
