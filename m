Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275682AbRIZXEM>; Wed, 26 Sep 2001 19:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275683AbRIZXED>; Wed, 26 Sep 2001 19:04:03 -0400
Received: from mail.zmailer.org ([194.252.70.162]:4112 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S275682AbRIZXDu>;
	Wed, 26 Sep 2001 19:03:50 -0400
Date: Thu, 27 Sep 2001 02:04:09 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Robert Williamson <robbiew@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DELIVERY FAILURE: 550 5.7.1 Policy analysis reported: This is not accepted relay target rcpt=<kernel@vger.kernel.org>
Message-ID: <20010927020409.J11046@mea-ext.zmailer.org>
In-Reply-To: <OF9A32B0A3.D22ECF1C-ON85256AD3.006FC573@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9A32B0A3.D22ECF1C-ON85256AD3.006FC573@raleigh.ibm.com>; from robbiew@us.ibm.com on Wed, Sep 26, 2001 at 03:22:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 03:22:01PM -0500, Robert Williamson wrote:
> To:	linux-kernel@vger.kernel.org
> X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
> From:	"Robert Williamson" <robbiew@us.ibm.com>
> Date:	Wed, 26 Sep 2001 15:22:01 -0500
> X-MIMETrack: Serialize by Router on D04NMS96/04/M/IBM(Release 5.0.8 |June 18, 2001) at
>  09/26/2001 04:22:05 PM
> 
> Local mail server did this...I apologize.

     Yes.  I noticed that it is tainted by the touch of Lotus Notes..

     My opinnions re that product are not great, but with its email
     functions I know only about problems occurring with it.
     ( I _do_ have skewed world-view, postmaster collects errors! )
     It may be great system for what it was/is originally built for,
     but connection with the Internet Email might not be it in the
     _general_ case.  Not even now, years after those interfaces have
     been pioneered, and should have been debugged throughout.

     It might even be a pilot error at the admin chair.

     That thing does apparently still exhibit what I call "LAN EMAIL"
     mentality:   If there occurs some problem, thing with it goes and
     scans visible headers for possible addresses, and blasts all those
     with its cry.  The correct address is of course the SMTP-level
     transport MAIL FROM address,  and in case of virus scanners,
     perhaps also the RCPT TO recipients.

> - Robbie
> 
> Robert V. Williamson
> Linux Test Project
> IBM Linux Technology Center
> http://ltp.sourceforge.net

/Matti Aarnio  co-postmaster of vger.kernel.org
