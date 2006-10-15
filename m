Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWJOVhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWJOVhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161189AbWJOVhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 17:37:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161188AbWJOVht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 17:37:49 -0400
Message-ID: <4532AA0E.8070908@redhat.com>
Date: Sun, 15 Oct 2006 14:37:18 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] close mprotect noexec hole
References: <200610151834.k9FIYBK5015809@devserv.devel.redhat.com> <Pine.LNX.4.64.0610151141280.3952@g5.osdl.org> <4532889B.1030908@redhat.com> <Pine.LNX.4.64.0610151226140.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610151226140.3952@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> This is equally untested as the previous version, but I think this is 
> really conceptually the Right Thing(tm).

Works for me here.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
