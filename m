Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264648AbSJ3KAu>; Wed, 30 Oct 2002 05:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264650AbSJ3KAu>; Wed, 30 Oct 2002 05:00:50 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:55708
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264648AbSJ3KAt>; Wed, 30 Oct 2002 05:00:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Russell King <rmk@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 05:07:07 -0500
User-Agent: KMail/1.4.2
Cc: Miles Bader <miles@gnu.org>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <3DBFA0F8.9000408@pobox.com> <20021030093437.A27726@flint.arm.linux.org.uk>
In-Reply-To: <20021030093437.A27726@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300507.07593.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 4:34, Russell King wrote:

> - there's no need to mount a ramfs filesystem,

An implementation flaw I think I pointed out to Al a year ago.
You can not set a size limit on your root othewise.
That's why I mount a '/dev/tmpfs/'.

My patch will cometh later today. I need some sleep right now.

Dave

-- 
The time is now 22:48 (Totalitarian)  -  http://www.ccops.org/

