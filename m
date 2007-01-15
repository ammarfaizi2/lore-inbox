Return-Path: <linux-kernel-owner+w=401wt.eu-S1751287AbXAOS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAOS3B (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXAOS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:29:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:42798 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXAOS3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:29:00 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=eXUx/tCEog0y8/Kkk+MEuZGuRlVR/4mRzjvY+msueMoY0mHofOUBcrStBkpoX7Q5iEQoTU+/F6ZpojuQwfLUMXuWqLvBhQGJ0wgpCyek7qgbYcywdA3V/vtf2TvLYx3fviPKxVPYwSypIs6Zxx7VBqL905v69IOo8SyHB4p3m3s=
Date: Mon, 15 Jan 2007 18:26:42 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: ris <ris@elsat.net.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High CPU usage with sata_nv
Message-ID: <20070115182642.GA18374@slug>
References: <20070115164541.M22367@elsat.net.pl> <20070115165432.M87238@elsat.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115165432.M87238@elsat.net.pl>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 06:54:50PM +0200, ris wrote:
> I have motherboard with nforce 590 SLI (MCP55) chipset.
> On other systems all its ok.
> 
> But i tried a lot o kernels, configurations and always get cpu at 100% when
> copying files.
> I use SATA II samsung hard drive.
> 
Any dmesg complain? Could you send the hdparm -I <your drive> ?
Regards,
Frederik
