Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbUK3WLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbUK3WLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbUK3WLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:11:10 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:32743 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262348AbUK3WLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:11:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=pxl4PyKFD6AoTtS6VJiH7YLWqvCcK5hnnYI/T1pll1avgyLL8Hi5+Fsneq2J4dM3RZ5xxpr1yKAwqopSCBdNUzp9B/P9ylyCfs8/9MZ+aJJS8kbsTbr5i6z3CFggW4FRrrzoydLWUJdaPF1WJFiuBkWiw4zUZyJE3acNkaobL4s=
Message-ID: <ce70c490411301411e8de2ee@mail.gmail.com>
Date: Tue, 30 Nov 2004 20:11:05 -0200
From: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
Reply-To: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Information about move_tasks return
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So as the "documentation" states, it returns the number of tasks
> actually moved.  For instance, The balancing code may request 4 tasks be
> moved, but for various reasons, only 2 were actually moved to other
> CPUs, move_tasks() would return 2.

hi,

Can you speak more about those various reasons? or tell me where I can
find out more information ?


[]s
:wq!
