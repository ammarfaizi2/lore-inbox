Return-Path: <linux-kernel-owner+w=401wt.eu-S965121AbWLMT5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWLMT5a (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWLMT52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:57:28 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:41108 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965121AbWLMT51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:57:27 -0500
Message-ID: <45805B23.9000901@scientia.net>
Date: Wed, 13 Dec 2006 20:57:23 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Karsten Weiss <K.Weiss@science-computing.de>, linux-kernel@vger.kernel.org,
       Erik Andersen <andersen@codepoet.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <4580529B.70202@scientia.net> <20061213195420.GB16112@tuatara.stupidest.org>
In-Reply-To: <20061213195420.GB16112@tuatara.stupidest.org>
Content-Type: multipart/mixed;
 boundary="------------020302030206080805090508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302030206080805090508
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Chris Wedgwood wrote:
>> Did anyone made any test under Windows? I cannot set there
>> iommu=soft, can I?
>>     
> Windows never uses the hardware iommu, so it's always doing the
> equivalent on iommu=soft
>   
That would mean that I'm not able to reproduce the issue unter windows,
right?
Does that apply for all versions (up to and including Vista).

Don't understand me wrong,.. I don't use Windows (expect for upgrading
my Plextor firmware and EAC ;) )... but I ask because the more
information we get (even if it's not Linux specific) the more steps we
can take ;)

Chris.


--------------020302030206080805090508
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------020302030206080805090508--
