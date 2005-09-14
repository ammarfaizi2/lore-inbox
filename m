Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbVINKxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVINKxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVINKxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:53:30 -0400
Received: from main.gmane.org ([80.91.229.2]:9191 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932718AbVINKx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:53:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nuutti Kotivuori <naked@iki.fi>
Subject: Re: netfilter QUEUE target and packet socket interactions buggy or not
Date: Wed, 14 Sep 2005 14:20:07 +0300
Organization: Ye 'Ol Disorganized NNTPCache groupie
Message-ID: <87r7br99qw.fsf@aka.i.naked.iki.fi>
References: <87fysa9bqt.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: naked.iki.fi
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
Cancel-Lock: sha1:iKh4tW9zOP3WEpGH+MAS+Y+ouXw=
Cache-Post-Path: aka.i.naked.iki.fi!unknown@aka.i.naked.iki.fi
X-Cache: nntpcache 3.0.1 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuutti Kotivuori wrote:
> I am in the process of debugging a kernel panic manifested on a Red
> Hat Enterprise Linux 4 under rather difficult conditions. While
> investigating this, I came upon a few bits of code that I'd like some
> clarification on. However, I will start by describing the problem.

Just as a heads up, I have now confirmed that the problem does not
happen on vanilla 2.6.13.1. The config is a bit different, but mostly
the same - although I had to disable SELinux due to other reasons, so
that might still be the culprit. Or the bug may have been fixed, or
never existed, in the mainline kernel.

-- Naked


