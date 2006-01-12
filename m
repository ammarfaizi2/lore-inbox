Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWALXLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWALXLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161447AbWALXLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:11:24 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:28904 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1161451AbWALXLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:11:23 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Does a git pull have to be so big?
Date: Fri, 13 Jan 2006 09:11:46 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601130845.29797.ncunningham@cyclades.com> <20060112225434.GA27678@havoc.gtf.org>
In-Reply-To: <20060112225434.GA27678@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601130911.46761.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Friday 13 January 2006 08:54, Jeff Garzik wrote:
> On Fri, Jan 13, 2006 at 08:45:29AM +1000, Nigel Cunningham wrote:
> > I try to do pulls reasonably often, but they always seem to be huge
> > downloads - I'm sure they're orders of magnitude bigger than a simple
> > patch would be. This leads me to ask, do they have to be so big? I'm on
> > 256/64 ADSL at home, did a pull yesterday at work iirc, and yet the pull
> > this morning has taken at least half an hour. Am I perhaps doing
> > something wrong?
>
> Two answers here:
>
> 1) Every so often, you download the entire kernel history all over
> again, if you are using pack files, since most repositories are repacked
> occasionally.

Thanks for the reply. Can I avoid using pack files with Linus' tree? If so, 
how?

> 2) Every change sends the full updated (albeit compressed) file,
> not a patch.

Ok. I can cope with that. Redownloading the whole history however, I'd like to 
stop.

Regards,

Nigel
