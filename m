Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTGCXea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTGCXea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 19:34:30 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:18889 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265500AbTGCXe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 19:34:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "ismail (cartman) donmez" <kde@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1 and Con Kolivas' CPU scheduler work
Date: Fri, 4 Jul 2003 09:49:18 +1000
User-Agent: KMail/1.5.2
References: <200307031936.34458.kde@myrealbox.com>
In-Reply-To: <200307031936.34458.kde@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307040949.18588.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003 02:36, ismail (cartman) donmez wrote:
> Hi,
>
> With Con Kolivas' cpu patch I got many slow downs. When I try to run
> CodeWeaver's CrossOver office box gets unresponsive at least for a one
> minute. While starting KDE ( when splash screen is running ) mouse gets too
> sluggish.

While your wm starting if your mouse is sluggish it is probably not a big 
problem, and it is part of something I'm already working on. The codeweavers 
problem is impressive though; I don't have codeweavers and have not seen 
anything like it. To get a full picture it would be helpful if you could run 
top as root say reniced to -13 just so it doesn't miss anything, and then 
start codeweavers, watch top and tell me what is spinning away hogging the 
cpu.

Con

> I tried Con's patch with 2.5.73-mm3 too and had same overall bad affects.
> 2.5.73-mm3 works very good.

Work with me and I'll try to improve your experience.

> Anyone has an idea whats might be wrong?

Con

