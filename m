Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSICPwH>; Tue, 3 Sep 2002 11:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSICPwH>; Tue, 3 Sep 2002 11:52:07 -0400
Received: from tapu.f00f.org ([66.60.186.129]:45698 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S317068AbSICPwG>;
	Tue, 3 Sep 2002 11:52:06 -0400
Date: Tue, 3 Sep 2002 08:56:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
Message-ID: <20020903155638.GA30659@tapu.f00f.org>
References: <Pine.LNX.4.44L.0209031243450.1519-100000@duckman.distro.conectiva> <200209031550.g83FogE03775@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209031550.g83FogE03775@oboe.it.uc3m.es>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 05:50:42PM +0200, Peter T. Breuer wrote:

    Yes, I do have synchronization - locks are/can be shared between both
    kernels using a device driver mechanism that I implemented.

What happens if one of the kernels/nodes dies?


  --cw
