Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSDIWXq>; Tue, 9 Apr 2002 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSDIWXp>; Tue, 9 Apr 2002 18:23:45 -0400
Received: from dsl-213-023-030-077.arcor-ip.net ([213.23.30.77]:60320 "EHLO
	duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S311885AbSDIWXo>; Tue, 9 Apr 2002 18:23:44 -0400
Date: Wed, 10 Apr 2002 00:23:37 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020409222337.GB31954@duron.intern.kubla.de>
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <20020409221725.GA23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 03:17:25PM -0700, Mike Fedyk wrote:
> On Tue, Apr 09, 2002 at 06:46:05PM -0300, Alexis S. L. Carvalho wrote:
> > Hi
> > 
> > Does anyone know of any implementation of soft-updates over ext2? I'm
> > starting a project on this for grad school, and I'd like to know of any
> > previous (current?) efforts.
> > 
> 
> Heh, ext3? ;)

No. Ext3 uses journalling. Soft-updates is something different.

Dominik
-- 
"Those who would give up essential Liberty to purchase a little
temporary Safety deserve neither Liberty nor Safety." (Benjamin Franklin)
