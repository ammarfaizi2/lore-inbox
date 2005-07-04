Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVGDL3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVGDL3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 07:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGDL3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 07:29:33 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:47033 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261394AbVGDL04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 07:26:56 -0400
Date: Mon, 4 Jul 2005 13:26:55 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging? (2)
Message-ID: <20050704112655.GA7883@janus>
References: <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703141028.GB1298@janus> <E1Dp6hK-00056d-00@dorka.pomaz.szeredi.hu> <20050703193619.GA2928@janus> <E1DpMkg-00064O-00@dorka.pomaz.szeredi.hu> <20050704095914.GA6949@janus> <E1DpOAT-00069p-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DpOAT-00069p-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 12:27:13PM +0200, Miklos Szeredi wrote:
> E.g. with "mount_nonempty" it would not refuse to
> mount on a non-leaf dir, and README would document, that using this
> option might cause trouble.  Otherwise the mount would be refused with
> a reference to the above option.

that will do.

-- 
Frank
