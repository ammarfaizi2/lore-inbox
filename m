Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291277AbSBGUaO>; Thu, 7 Feb 2002 15:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291282AbSBGU34>; Thu, 7 Feb 2002 15:29:56 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:24641 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S291278AbSBGU3n>; Thu, 7 Feb 2002 15:29:43 -0500
Date: Thu, 7 Feb 2002 21:34:24 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: Re: Warning, 2.5.3 eats filesystems
Message-ID: <20020207203424.GA2738@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <20020206233051.GA503@chiara.cavy.de> <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.5.0-hc8-current-20020125i (Linux 2.4.18-pre8-m i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 06 2002, Alexander Viro wrote:

> Very interesting.  Which filesystems are mounted (other than ext2) and
> are you been able to reproduce it on 2.5.3-pre6?

There are only ext2 filesystems available and one cd-rom.

I installed 2.5.3-pre6 and the machine runs for about 6 hours now
(heavy load) and no error occured yet.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
