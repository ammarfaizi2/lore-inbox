Return-Path: <linux-kernel-owner+w=401wt.eu-S1752041AbXAROeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXAROeP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbXAROeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:34:15 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:40415 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752041AbXAROeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:34:14 -0500
Message-ID: <45AF8561.6010900@scientia.net>
Date: Thu, 18 Jan 2007 15:34:09 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: joachim <joachim.kernel@googlemail.com>
CC: Andi Kleen <ak@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de> <45AF3DEA.1070309@gmail.com>
In-Reply-To: <45AF3DEA.1070309@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010403060701070005040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403060701070005040901
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

joachim wrote:
> Not only has it only been on Nvidia chipsets but we have only seen
> reports on the Nvidia CK804 SATA controller.  Please write in or add
> yourself to the bugzilla entry [1] and tell us which hardware you have
> if you get 4kB pagesize corruption and it goes away with "iommu=soft".
How do I find out if I get a 4kB pagesize corruption (or is this the
same as "our corruption"?

Chris.

btw: Should we only post the controller, or other hardware details, too?

--------------010403060701070005040901
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010403060701070005040901--
