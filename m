Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSBDMeF>; Mon, 4 Feb 2002 07:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288953AbSBDMd4>; Mon, 4 Feb 2002 07:33:56 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:23207 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288950AbSBDMdj>; Mon, 4 Feb 2002 07:33:39 -0500
Date: Mon, 4 Feb 2002 07:33:28 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
Message-ID: <20020204073328.A1179@devserv.devel.redhat.com>
In-Reply-To: <20020204123247.22C3E9000@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020204123247.22C3E9000@oscar.casa.dyndns.org>; from tomlins@cam.org on Mon, Feb 04, 2002 at 07:32:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 07:32:46AM -0500, Ed Tomlinson wrote:
> > sharing the same Thread Group ID would be a very obvious quantity to
> > check,
> > and would very much show the indication of the application author.
> 
> I Tried this.  Looks like not all (many?) apps actually use this.

would be a case of fixing those apps imo
