Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSFUSoI>; Fri, 21 Jun 2002 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSFUSoH>; Fri, 21 Jun 2002 14:44:07 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:14929 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S316750AbSFUSoH>; Fri, 21 Jun 2002 14:44:07 -0400
Date: Fri, 21 Jun 2002 21:44:00 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020621184400.GB1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020620103429.A2464@redhat.com> <20020620101812.GL22427@clusterfs.com> <E17L2G0-00019Q-00@starship> <20020621145451.GA1548@niksula.cs.hut.fi> <20020621160833.D2805@redhat.com> <20020621153801.GK1465@niksula.cs.hut.fi> <20020621171550.E2805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621171550.E2805@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 05:15:50PM +0100, you [Stephen C. Tweedie] wrote:
> Hi,
> 
> On Fri, Jun 21, 2002 at 06:38:01PM +0300, Ville Herva wrote:
>  
> > So I thought, but not in ext2?
> 
> It's in ext2 --- it's the i_dir_start_lookup field that remembers
> where we were last.

Great. (Unfortunately the box that experienced the named incident was a
2.2.20 + patches, so obviously the patch didn't help there :/ ).


-- v --

v@iki.fi
