Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312499AbSDJGxn>; Wed, 10 Apr 2002 02:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSDJGxm>; Wed, 10 Apr 2002 02:53:42 -0400
Received: from zok.sgi.com ([204.94.215.101]:39347 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S312499AbSDJGxj>;
	Wed, 10 Apr 2002 02:53:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Mathew, Tisson K" <tisson.k.mathew@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inserting modules w/o version check 
In-Reply-To: Your message of "Tue, 09 Apr 2002 09:37:14 MST."
             <794826DE8867D411BAB8009027AE9EB911C10AE5@FMSMSX38> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Apr 2002 16:53:20 +1000
Message-ID: <4025.1018421600@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002 09:37:14 -0700 , 
"Mathew, Tisson K" <tisson.k.mathew@intel.com> wrote:
>Can we enforce no version check for modules when they are inserted ( insmod
>) ? If yes , can this be implemented in the module itself ?

insmod -f, but don't bother sending bug reports to l-k after a forced
insert.

