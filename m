Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbTHQMwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTHQMwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:52:37 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:59858 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S269628AbTHQMwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:52:36 -0400
From: Daniel Phillips <phillips@arcor.de>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [BUG]  Serious scheduler starvation
Date: Sun, 17 Aug 2003 14:55:53 +0200
User-Agent: KMail/1.5.3
References: <yw1xekzkv5yv.fsf@users.sourceforge.net>
In-Reply-To: <yw1xekzkv5yv.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200308171455.53822.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 August 2003 14:11, Måns Rullgård wrote:
> What can I do to collect more information about the problem?

Look in top's "PRI" column, which is where you see the effects of the dynamic 
priority adjustment.

Regards,

Daniel

