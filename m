Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRHHAdT>; Tue, 7 Aug 2001 20:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270250AbRHHAdK>; Tue, 7 Aug 2001 20:33:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:50928
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S270274AbRHHAcu>; Tue, 7 Aug 2001 20:32:50 -0400
Date: Tue, 7 Aug 2001 17:32:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x VM problems thread
Message-ID: <20010807173255.L22821@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108072240300.3714-200000@jdi.jdimedia.nl> <Pine.LNX.4.33.0108080223550.17520-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108080223550.17520-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 02:24:37AM +0200, Luigi Genoni wrote:
> This kind of code would kill any Unix system, i think, not just linux 2.4
> boxes.
> 

I tried it on 2.2.19-ppc and could kill it with ^C at the prompt, or from
root if I was already logged in.  Trying to iniate connections to ssh didn't
produce any results after about 30 seconds.

Once it was killed the system was fine.

Haven't tried 2.4 yet...
