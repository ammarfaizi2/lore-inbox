Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWBTRdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWBTRdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBTRdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:33:31 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:11888 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161070AbWBTRda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:33:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P6zEen2sp46veQ7cdxjhD16PBprz5/h7KmSxawocvjASSlmJAQmJfMs15jNKUr0jPemYf0FKKiYwXtKO+jEEFuYywxfrejOYzw41srlu7mnizTsYQv6wYoCmaHMWHljs4q2lSzbBeqN3q0LxL38X5s9mDU7L9ZtOb2/yn9Lx96s=
Message-ID: <d120d5000602200933v24cf9fbchb44c229459d74179@mail.gmail.com>
Date: Mon, 20 Feb 2006 12:33:29 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "Pavel Machek" <pavel@ucw.cz>, "Mark Lord" <lkml@rtr.ca>,
       "Nigel Cunningham" <nigel@suspend2.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200602201823.22870.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602201722.09442.rjw@sisk.pl>
	 <d120d5000602200830m190874f5jf253b106b6821049@mail.gmail.com>
	 <200602201823.22870.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 20 February 2006 17:30, Dmitry Torokhov wrote:
> >
> > Latest -mm is way too big a target. Do you have a specific patches in
> > mind? Again my working kernel is based off tip of Linus's tree plus my
> > patches, not -mm.
>
> What architecture is it running on?
>

i386, nothing fancy.

--
Dmitry
