Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTFYRCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbTFYRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:02:00 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28423 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264672AbTFYRB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:01:59 -0400
Date: Wed, 25 Jun 2003 18:16:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mocm@mocm.de
Cc: Christoph Hellwig <hch@infradead.org>,
       Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625181606.A29104@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
	Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030625150629.GA1045@mars.ravnborg.org> <20030625160830.A19958@infradead.org> <20030625154223.GB1333@mars.ravnborg.org> <3EF9CB25.4050105@convergence.de> <16121.53934.527440.109966@sheridan.metzler> <20030625175513.A28776@infradead.org> <16121.55366.94360.338786@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16121.55366.94360.338786@sheridan.metzler>; from mocm@metzlerbros.de on Wed, Jun 25, 2003 at 07:13:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 07:13:42PM +0200, Marcus Metzler wrote:
> Strange, so why do you have include/linux/videodev.h and look at it
> with user space applications?

I don't look at it with userspace applications (ecept maybe less or cat..)
and any application including it is broken.

> I am talking about 
> ../include/linux/dvb/video.h
> ../include/linux/dvb/version.h
> ../include/linux/dvb/osd.h
> ../include/linux/dvb/net.h
> ../include/linux/dvb/frontend.h
> ../include/linux/dvb/dmx.h
> ../include/linux/dvb/ca.h
> ../include/linux/dvb/audio.h
> 
> Don't you like the extra directory?


