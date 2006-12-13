Return-Path: <linux-kernel-owner+w=401wt.eu-S1750753AbWLMUcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWLMUcO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLMUcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:32:13 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:41578 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750748AbWLMUcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:32:12 -0500
Message-ID: <45806349.70707@scientia.net>
Date: Wed, 13 Dec 2006 21:32:09 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: andersen@codepoet.org, Karsten Weiss <K.Weiss@science-computing.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org>
In-Reply-To: <20061213202925.GA3909@codepoet.org>
Content-Type: multipart/mixed;
 boundary="------------000409030605090802070302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409030605090802070302
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Erik Andersen wrote:
> I just realized that booting with "iommu=soft" makes my pcHDTV
> HD5500 DVB cards not work.  Time to go back to disabling the
> memhole and losing 1 GB.  :-(
Crazy,...
I have a Hauppauge Nova-T 500 DualDVB-T card,... I'll check it later if
I have the same problem and will inform you (please remember me if I
forget ;) )


Chris.

--------------000409030605090802070302
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------000409030605090802070302--
