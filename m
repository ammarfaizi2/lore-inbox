Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUHKHeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUHKHeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 03:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUHKHeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 03:34:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58764 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267978AbUHKHeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 03:34:04 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xd61y876s.fsf@kth.se>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092092365.461905.29067.502@pc.kolivas.org>
	 <1092099669.5759.283.camel@cube> <yw1xisbrflws.fsf@kth.se>
	 <1092148392.5818.6.camel@mindpipe> <yw1xllgm8quu.fsf@kth.se>
	 <1092193620.784.29.camel@mindpipe>  <yw1xd61y876s.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1092209667.1650.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 03:34:28 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 03:28, Måns Rullgård wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> >
> > I sent this patch to the jackit-devel list, and everyone seems to think
> > this would be a useful feature; had this been around a few years ago it
> > certainly would have aided JACK's development.
> 
> So why didn't anyone write it earlier?
> 

Eh, possibly it's one of those things that's very useful in theory but
that no one ever actually needed enough to write.  JACK has been stable
for a while now and has mechanisms for preventing buggy clients from
locking the machine.

Lee

