Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUGJRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUGJRhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUGJRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 13:37:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10165 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266311AbUGJRhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 13:37:34 -0400
Message-ID: <40F02963.5040500@namesys.com>
Date: Sat, 10 Jul 2004 10:37:39 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: jmerkey@comcast.net, Pete Harlan <harlan@artselect.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net> <40EF797E.6060601@namesys.com> <20040710083347.GC6386@redhat.com>
In-Reply-To: <20040710083347.GC6386@redhat.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>
>The *only* times we _refuse_ to apply bugfixes are when said bugfixes
>cause more problems than they are alleged to fix, or when those
>fixes aren't relevant for some reason, but don't let facts get in
>the way of a good rant.
>
>  
>
You guys have refused to apply reiserfs bugfixes for a long time.  Users 
don't know that redhat doesn't apply our bugfixes, and when they use 
redhat and decide to experiment with reiserfs, they encounter bugs and 
conclude that RedHat is right to not support reiserfs, which is exactly 
the redhat intended effect.

Fedora is something new.  It is good that fedora tracks the mainline.  
Kudos for that.  You should do that with RHEL.
