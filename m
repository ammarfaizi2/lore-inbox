Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTFZUEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTFZUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:04:12 -0400
Received: from smtp.terra.es ([213.4.129.129]:48997 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S263737AbTFZUEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:04:10 -0400
Date: Thu, 26 Jun 2003 22:16:39 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, efault@gmx.de, felipe_alfaro@linuxmail.org
Subject: Re: patch O1int for 2.5.73 - interactivity work
Message-Id: <20030626221639.7c9f37d6.diegocg@teleline.es>
In-Reply-To: <200306260209.45020.kernel@kolivas.org>
References: <200306260209.45020.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003 02:09:45 +1000
Con Kolivas <kernel@kolivas.org> wrote:

> Please comment and test if you can.


Fixes the very bad behaviuor plain (or -mm) 2.5.73 behaviour has, when
for example, i check for new mail with sylpheed and it merges
the new messages in the 114 MB lmkl folder....(mouse isn't reponsive,
and this is a SMP box)
