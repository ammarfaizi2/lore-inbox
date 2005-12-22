Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVLVXJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVLVXJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVLVXJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:09:25 -0500
Received: from imladris.surriel.com ([66.92.77.98]:57744 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S1030360AbVLVXJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:09:24 -0500
Date: Thu, 22 Dec 2005 18:09:19 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Tetsuo Handa <from-kernelnewbies@i-love.sakura.ne.jp>
cc: arjan@infradead.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: [RFC] TOMOYO Linux released!
In-Reply-To: <200512212112.HBH59669.FCNLMTFJFFSSPGtOOX@i-love.sakura.ne.jp>
Message-ID: <Pine.LNX.4.61L.0512221808160.6194@imladris.surriel.com>
References: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>
 <1135164793.3456.9.camel@laptopd505.fenrus.org>
 <200512212112.HBH59669.FCNLMTFJFFSSPGtOOX@i-love.sakura.ne.jp>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Tetsuo Handa wrote:

> > 1) where can we download the patches?

> You can download from http://sourceforge.jp/projects/tomoyo/ .

Why does the Tomoyo patch have its own hooks in various
places sitting right next to the LSM hooks?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
