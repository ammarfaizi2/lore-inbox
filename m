Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSGKXSj>; Thu, 11 Jul 2002 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSGKXSi>; Thu, 11 Jul 2002 19:18:38 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19446 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317945AbSGKXSg>; Thu, 11 Jul 2002 19:18:36 -0400
Date: Thu, 11 Jul 2002 19:21:19 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: angus <angus@mcm.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.14 error: ini9100u.c
Message-ID: <20020711192119.G4315@redhat.com>
References: <1020675649.20692.6.camel@localhost.localdomain> <3CD74E41.D39C1F23@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CD74E41.D39C1F23@torque.net>; from dougg@torque.net on Mon, May 06, 2002 at 11:47:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 11:47:13PM -0400, Douglas Gilbert wrote:
> -#error Please convert me to Documentation/DMA-mapping.txt
> +/* #error Please convert me to Documentation/DMA-mapping.txt */

Please read the document the comment points to, *then* rewrite the 
patch.

		-ben
