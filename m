Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTFKPho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFKPho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:37:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1708
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262430AbTFKPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:37:38 -0400
Subject: Re: WESTERN DIGITAL 200GB IDE DRIVES GO OFFLINE - HOW TO FIX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: war <war@lucidpixels.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apiszcz@solarrain.com
In-Reply-To: <Pine.LNX.4.53.0306111115530.14178@p500>
References: <Pine.LNX.4.53.0306111115530.14178@p500>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055346538.2420.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 16:48:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 16:36, war wrote:
> I've searched the archives, google and so on, many questions relating to
> why the Western Digital drives go offline exist but with no answers.
> 
> PROBLEM: After extended periods of time, the HDD will simply go offline.
> 
> EXAMPLE LOG ENTRY:
> 
> Jun  2 02:07:26 l2 kernel: hdg: dma_intr: status=0x61 { DriveReady
> DeviceFault Error }
> Jun  2 02:07:26 l2 kernel: hdg: dma_intr: error=0x04 { DriveStatusError }
> Jun  2 02:07:26 l2 kernel: hdg: DMA disabled

"DeviceFault" and "Error"

Those are return values I associate with device (ie hardware) faults
oddly enough 8)

