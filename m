Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUEGKbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUEGKbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 06:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUEGKbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 06:31:42 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:64009 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263529AbUEGKbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 06:31:01 -0400
Date: Fri, 7 May 2004 12:28:28 +0200
From: DervishD <raul@pleyades.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: Oliver Pitzeier <oliver@linux-kernel.at>, linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!?
Message-ID: <20040507102828.GF11768@DervishD>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Oliver Pitzeier <oliver@linux-kernel.at>,
	linux-kernel@vger.kernel.org
References: <013001c4340d$e9860470$d50110ac@sbp.uptime.at> <13183.1083919405@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13183.1083919405@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Keith :)

 * Keith Owens <kaos@ocs.com.au> dixit:
> On Fri, 7 May 2004 10:33:02 +0200, 
> "Oliver Pitzeier" <oliver@linux-kernel.at> wrote:
> >We have a machine with five partitions mounted. One of those partitions
> >is /usr. We can created files on /usr, but we cannot created
> >directories. mkdir says, that there is no space left on device, but
> >there actually IS space as you can see and files can be created, so why
> >NO directories?
> df -i, you have run out of inodes.

    But if you have run out of inodes, you cannot create files
neither, am I wrong? Olives states clearly in his message that files
can be created, but no directories :?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
