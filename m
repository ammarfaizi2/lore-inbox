Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278549AbRJaAwj>; Tue, 30 Oct 2001 19:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278597AbRJaAw3>; Tue, 30 Oct 2001 19:52:29 -0500
Received: from gateway.digeo.com ([209.100.206.194]:59027 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S278549AbRJaAwN>; Tue, 30 Oct 2001 19:52:13 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Identify IDE device?
From: Mark Atwood <mra@pobox.com>
Date: 30 Oct 2001 16:52:46 -0800
In-Reply-To: Linus Torvalds's message of "Tue, 30 Oct 2001 15:04:04 -0800 (PST)"
Message-ID: <m3pu74k4v5.fsf@khem.blackfedora.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a way, via an ioctl call, or something to identify what
specific IDE hard disk or other IDE device is hooked up to the IDE
controller?

I'm really hoping to be able to determine something like "/dev/hda is
a Maxtor 96147H6".

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
