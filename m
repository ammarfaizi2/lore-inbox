Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290798AbSBFUlG>; Wed, 6 Feb 2002 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290795AbSBFUk4>; Wed, 6 Feb 2002 15:40:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290798AbSBFUkp>;
	Wed, 6 Feb 2002 15:40:45 -0500
Message-ID: <3C6194C5.2561A0C8@mandrakesoft.com>
Date: Wed, 06 Feb 2002 15:40:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kirk Reiser <kirk@braille.uwo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need a clew WRT fig2dev
In-Reply-To: <x7zo2mzi5v.fsf@speech.braille.uwo.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirk Reiser wrote:
> Hi Folks: I have been trying to make the docbook documentation in the
> 2.5.3 tree but have run into a problem not having fig2dev.  I do not
> seem to be able to find this utility or any reference to it.  It does
> not appear to be in my docbook utilities at any rate.  Any suggestions
> would certainly be appreciated.

[jgarzik@cum rpm]$ rpm -qf `which fig2dev`
transfig-3.2.3d-7mdk

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
