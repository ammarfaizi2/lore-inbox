Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVADTAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVADTAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVADTAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:00:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6309 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261799AbVADTAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:00:01 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <87u0pxhvn0.fsf@sulphur.joq.us>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org>  <87u0pxhvn0.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 13:59:57 -0500
Message-Id: <1104865198.8346.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 12:55 -0600, Jack O'Quin wrote:
> But, the lack of this feature has been a continual impediment for
> years now.  It affects not just me, but most other serious Linux audio
> developers and many of our users.  We need a simple way for users to
> configure a Digital Audio Workstation without having to run large,
> complex, insecure audio applications as `root'.  Our competition runs
> on Windows and Mac systems where no such configuration is needed.

We could do it the was OSX (our real competition) does if that would
make people happy.  They just let any user run RT tasks.  Oh wait, but
that's a "broken design", everyone knows that OSX is a joke, no one
would use *that* OS to mix a CD or score a movie.  :-)

Lee

 

