Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269675AbUJMLGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269675AbUJMLGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 07:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269678AbUJMLGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 07:06:31 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:36645 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269675AbUJMLGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 07:06:30 -0400
Message-ID: <c461c0d10410130406714fafe3@mail.gmail.com>
Date: Wed, 13 Oct 2004 12:06:29 +0100
From: Alex Kiernan <alex.kiernan@gmail.com>
Reply-To: Alex Kiernan <alex.kiernan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run into a bug in the UFS reading code (on Solaris x86 the
major/minor numbers are in 2nd indirect offset not the first), so I've
patched it & bugzilled it
(http://bugzilla.kernel.org/show_bug.cgi?id=3475).

But where do I go from here? There doesn't seem to be a maintainer for
UFS so I can't send it there.

-- 
Alex Kiernan
