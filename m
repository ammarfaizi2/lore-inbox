Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265205AbUE0UbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUE0UbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUE0UbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:31:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4738 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265197AbUE0UbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:31:20 -0400
Message-ID: <40B6500B.5000009@pobox.com>
Date: Thu, 27 May 2004 16:31:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Lazara <blazara@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] add new nForce IDE/SATA device IDs
References: <C064BF1617D93B4B83714E38C4653A6E0AF48249@mail-sc-10.nvidia.com>
In-Reply-To: <C064BF1617D93B4B83714E38C4653A6E0AF48249@mail-sc-10.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Lazara wrote:
> We do plan on moving our SATA support to libata.

cool


> Patches for 2.4.27-pre2 and 2.6.6 to add device IDs for new nForce IDE
> and SATA controllers. Rename some of the existing controller names to
> correctly match released product names. 

The patch looks OK to me, though the final call is up to Bart.

FWIW, when you included the patch inline, your email editor word-wrapped 
it so it will not apply.

If Microsoft Outlook (or whatever) cannot produce decent patches, you 
may need to include your patches _twice_ -- once in plaintext (with 
annoying word wrap) for review, and once as you did initially, as a 
base64 attachment.

Most MUA's are able to attach patches as plaintext (not base64), so see 
if there are setting you can flip...

	Jeff


