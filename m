Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTLIX6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTLIX6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:58:41 -0500
Received: from holomorphy.com ([199.26.172.102]:39648 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263526AbTLIX6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:58:40 -0500
Date: Tue, 9 Dec 2003 15:58:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jakma <paul@clubi.ie>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031209235823.GT8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jakma <paul@clubi.ie>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet> <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 11:46:13PM +0000, Paul Jakma wrote:
> This leaves 2.4 LVM1 users with a /huge/ leap to take if they wish to
> test 2.6. Backward compatibility is awkward because of the DM tools
> issue (need both old and new installed and some way to pick at boot,
> or manually setup LVM), and you're ruling out the other option of
> adding forwards compatibility to 2.4.
> This isnt a new fs which 2.4 users wont be using, its an existing 
> feature that has been reworked during 2.5 and is now incompatible in 
> 2.6 with 2.4. More over, its a feature on which access to data 
> depends.

Just apply the patch if you're for some reason terrified of 2.6.


-- wli
