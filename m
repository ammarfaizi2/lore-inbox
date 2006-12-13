Return-Path: <linux-kernel-owner+w=401wt.eu-S965139AbWLMUCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWLMUCo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWLMUCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:02:44 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:41202 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965139AbWLMUCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:02:38 -0500
Message-ID: <45805C5A.2060805@scientia.net>
Date: Wed, 13 Dec 2006 21:02:34 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Karsten Weiss <K.Weiss@science-computing.de>
CC: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213195305.GA3358@codepoet.org> <Pine.LNX.4.61.0612132056380.6688@palpatine.science-computing.de>
In-Reply-To: <Pine.LNX.4.61.0612132056380.6688@palpatine.science-computing.de>
Content-Type: multipart/mixed;
 boundary="------------030108030008050802080704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108030008050802080704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karsten Weiss wrote:
> "Memory hole mapping" was set to "hardware". With "disabled" we only
> see 3 of our 4 GB memory.
>   
That sounds reasonable,... I even only see 2,5 GB,.. as my memhole takes
1536 MB (don't ask me which PCI device needs that much address space ;) )

--------------030108030008050802080704
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030108030008050802080704--
