Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTDEBHK (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTDEBHK (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:07:10 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:42748 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S261649AbTDEBHJ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:07:09 -0500
Date: Fri, 4 Apr 2003 20:18:39 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AT_PLATFORM on HT-P4
Message-ID: <20030404201839.A21819@redhat.com>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405004327.GA11141@werewolf.able.es> <20030405005020.GA11904@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030405005020.GA11904@werewolf.able.es>; from jamagallon@able.es on Sat, Apr 05, 2003 at 02:50:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 02:50:20AM +0200, J.A. Magallon wrote:
> This makes P4 Xeon to report correct i686 platform. Without this, 
> all those people that think its ld.so automatically picks i686 libs
> are wrong...

Uhm, why are you posting a really tiny patch as a bzip2 that nobody can 
read or quote inline?

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
