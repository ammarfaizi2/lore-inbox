Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752461AbVHGRqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbVHGRqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbVHGRqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:46:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752461AbVHGRqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:46:08 -0400
Date: Sun, 7 Aug 2005 10:43:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Raymond Lai <raymond.kk.lai@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
       alsa-devel@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
Subject: Re: any update on the pcmcia bug blocking Audigy2 notebook sound
 card driver development
Message-Id: <20050807104332.320aec48.akpm@osdl.org>
In-Reply-To: <1ed860e3050807084449b0daac@mail.gmail.com>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raymond Lai <raymond.kk.lai@gmail.com> wrote:
>
> Hi all,
> 
> I remember there's a kernel pcmcia bug preventing the development for 
> the Audigy2 pcmcia notebook sound card driver. 
> 
> See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> 
> Is there any new updates on the situation? Has the bug been fixed? or
> anyone working on it?
> 

Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?
