Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVC3NAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVC3NAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVC3NAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:00:43 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:15087 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S261277AbVC3NAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:00:35 -0500
X-ME-UUID: 20050330130033359.579B71C00085@mwinf1201.wanadoo.fr
Message-ID: <424AA2F0.3090100@wanadoo.fr>
Date: Wed, 30 Mar 2005 15:00:32 +0200
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Yves Crespin <Crespin.Quartz@Wanadoo.fr>
Subject: Disable cache disk
Content-Type: multipart/mixed;
 boundary="------------080804070004080006030600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080804070004080006030600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I write a lot of files on a USB disk for video monitoring archiving.
The write program is faster than the USB.
Cache disk take all RAM and kernel start swapping and everything become 
very slow.
1/ is-it possible to *really* be synchronize. I prefer to have a blocked 
write() than use cache and get swap!
2/ is-it possible to disable cache disk ?

Thanks,

 Yves

--------------080804070004080006030600
Content-Type: text/x-vcard; charset=utf-8;
 name="crespin.quartz.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="crespin.quartz.vcf"

begin:vcard
fn:Yves Crespin
n:Crespin;Yves
org:Quartz
adr:Hameau du Pra - CIDEX 322;;39, rue Victor Hugo;CROLLES;;38920;France
email;internet:Crespin.Quartz@Wanadoo.fr
tel;work:04.76.92.21.91
tel;cell:06.86.42.86.81
x-mozilla-html:FALSE
url:http://crespin.quartz.free.fr/
version:2.1
end:vcard


--------------080804070004080006030600--

