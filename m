Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSLMQr2>; Fri, 13 Dec 2002 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSLMQr2>; Fri, 13 Dec 2002 11:47:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19966 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265132AbSLMQr1>; Fri, 13 Dec 2002 11:47:27 -0500
Date: Fri, 13 Dec 2002 11:55:08 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
Message-ID: <20021213115508.A16493@devserv.devel.redhat.com>
References: <3DF9F780.1070300@walrond.org> <mailman.1039792562.8768.linux-kernel2news@redhat.com> <200212131616.gBDGGH302861@devserv.devel.redhat.com> <3DFA0F6D.1010904@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFA0F6D.1010904@walrond.org>; from andrew@walrond.org on Fri, Dec 13, 2002 at 04:48:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 13 Dec 2002 16:48:45 +0000
> From: Andrew Walrond <andrew@walrond.org>

> Sorry for being dense, but what do you mean by 'bindings' ? Hard links?

$ man mount

       Since Linux 2.4.0 it is possible to remount part of the file  hierarchy
       somewhere else. The call is
              mount --bind olddir newdir
       After this call the same contents is accessible in two places.

-- Pete
