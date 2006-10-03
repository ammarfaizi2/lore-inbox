Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWJCPyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWJCPyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWJCPyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:54:07 -0400
Received: from web36612.mail.mud.yahoo.com ([209.191.85.29]:56702 "HELO
	web36612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030234AbWJCPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:54:05 -0400
Message-ID: <20061003155403.58948.qmail@web36612.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 3 Oct 2006 08:54:03 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [user question] security.mac.seeotheruids.enabled equivalent in Linux
To: Andrew Martin <andy.martin.p@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <126d7b5a0610030829h20e0b63ag8d56c3f9582063cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Andrew Martin <andy.martin.p@gmail.com> wrote:

> Thanks for reading my question :)
> 
> I am looking for a Linux equivalent of the
> security.mac.seeotheruids.enabled sysctl found on
> BSD. Preferably one
> that works with the latest vanilla mainline kernel.
> 
> Basically if it's switched off then users cannot see
> other users'
> processes, network connections, UNIX sockets,
> mounts, etc... but can
> still see if they are logged in or not.

SELinux might be your (current) best bet.


Casey Schaufler
casey@schaufler-ca.com
