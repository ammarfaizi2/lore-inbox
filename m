Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSDQQFD>; Wed, 17 Apr 2002 12:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSDQQFC>; Wed, 17 Apr 2002 12:05:02 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:56014 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293337AbSDQQFC>; Wed, 17 Apr 2002 12:05:02 -0400
Date: Wed, 17 Apr 2002 18:05:00 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kraxel@bytesex.org
Subject: Re: [BKPATCH 2.4] meye driver: get parameters from the kernel command line
Message-ID: <20020417160500.GJ1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kraxel@bytesex.org
In-Reply-To: <20020417155620.GF1519@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 05:56:20PM +0200, Stelian Pop wrote:

> Hi,
> 
> This patch enables the meye driver to get parameters on the 
> kernel command line using a "meye=" style syntax.
> 
> Marcelo, please apply.

It would be also nice if Gerd would push (again ?) its changes
(the video_generic_ioctl -> video_usercopy ones) to Marcelo...

This way we would have an identical API between 2.4 and 2.5 v4l drivers...

Gerd ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
