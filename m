Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJQFyX>; Wed, 17 Oct 2001 01:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274746AbRJQFyN>; Wed, 17 Oct 2001 01:54:13 -0400
Received: from rj.sgi.com ([204.94.215.100]:63159 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274681AbRJQFyH>;
	Wed, 17 Oct 2001 01:54:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols??? 
In-Reply-To: Your message of "Tue, 16 Oct 2001 21:59:03 MST."
             <Pine.LNX.4.33.0110162158450.6825-100000@devel.office> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Oct 2001 15:54:32 +1000
Message-ID: <31822.1003298072@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001 21:59:03 -0700 (PDT), 
Christoph Lameter <christoph@lameter.com> wrote:
>The loop driver is not GPL compatible???

In 2.4.11 loop.c has no MODULE_LICENCE.  It will take a while for all
modules to be correctly flagged.

