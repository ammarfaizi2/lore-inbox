Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSJQJsu>; Thu, 17 Oct 2002 05:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJQJsu>; Thu, 17 Oct 2002 05:48:50 -0400
Received: from pc-62-31-74-29-ed.blueyonder.co.uk ([62.31.74.29]:64896 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261228AbSJQJst>; Thu, 17 Oct 2002 05:48:49 -0400
Date: Thu, 17 Oct 2002 10:54:39 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>, sct@redhat.com,
       akpm@zip.com.au, adilger@clusterfs.com
Subject: Re: Latest ext3 merge in mainline lacks 2 hunks ?
Message-ID: <20021017105439.C3277@redhat.com>
References: <20021016204648.GA1616@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021016204648.GA1616@werewolf.able.es>; from jamagallon@able.es on Wed, Oct 16, 2002 at 10:46:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 16, 2002 at 10:46:48PM +0200, J.A. Magallon wrote:
 
> I  was patching mainline kernels with the ext3 update until this was
> merged recently.
> The merge differs from what I had (taken from LKML) in two missing hunks
> not present still in -pre11.
> Some of the maintainers can say if they are important ?

They are just minor performance-related tweaks that Marcelo wants to
defer merging until 2.4.21-pre opens.

Cheers,
 Stephen
