Return-Path: <linux-kernel-owner+w=401wt.eu-S964836AbXABMZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbXABMZY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbXABMZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:25:24 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1255 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964836AbXABMZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:25:23 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: isely@pobox.com
Subject: Re: [PATCH] video: pvrusb2-hdw kfree cleanup
Date: Tue, 2 Jan 2007 13:26:45 +0100
User-Agent: KMail/1.9.5
Cc: pvrusb2@isely.net, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
References: <200701021244.21728.m.kozlowski@tuxland.pl>
In-Reply-To: <200701021244.21728.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021326.46176.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> 	This patch removes redundant argument check for kfree().
> 
>  drivers/media/video/pvrusb2/pvrusb2-hdw.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

-- 
Regards,

	Mariusz Kozlowski
