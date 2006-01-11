Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWAKEoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWAKEoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 23:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWAKEoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 23:44:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58559 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751355AbWAKEoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 23:44:01 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.1.1
cc: linux-kernel@vger.kernel.org
Date: Tue, 10 Jan 2006 20:43:58 -0800
Message-ID: <7v64or1ii9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.1.1 is available at the usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.1.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.1-1.$arch.rpm	(RPM)

This is primarily to fix the build problems with RPM and tarball
releases.  I owe a big thanks to Peter Anvin for the fix.

----------------------------------------------------------------

Changes since v1.1.0 are as follows:

H. Peter Anvin:
      For release tarballs, include the proper version

Johannes Schindelin:
      glossary: explain "master" and "origin"

Junio C Hamano:
      GIT-VERSION-GEN: detect dirty tree and mark the version accordingly.



