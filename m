Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSLZDAo>; Wed, 25 Dec 2002 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLZDAo>; Wed, 25 Dec 2002 22:00:44 -0500
Received: from web40108.mail.yahoo.com ([66.218.78.42]:53400 "HELO
	web40108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261861AbSLZDAn>; Wed, 25 Dec 2002 22:00:43 -0500
Message-ID: <20021226030853.72178.qmail@web40108.mail.yahoo.com>
Date: Wed, 25 Dec 2002 19:08:53 -0800 (PST)
From: Munagala Ramanath <amberarrow@yahoo.com>
Subject: 2.5.53: Typos in Documentation/kbuild/kconfig-language.txt
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


21c21
< to determine the visible of an entry. Any child entry is only
---
> to determine the visibility of an entry. Any child entry is only
53c53
<   tristate and string, the other types base on these two. The type
---
>   tristate and string, the other types are based on these two. The
type
72c72
<   overriden by an earlier definition.
---
>   overridden by an earlier definition.
84c84
<   accept "if" expression), so these two examples are equivalent:
---
>   accept an "if" expression), so these two examples are equivalent:
95c95
<   the level indentation, this means it ends at the first line which
has
---
>   the indentation level, this means it ends at the first line which
has
133c133
< There are two type of symbols: constant and nonconstant symbols.
---
> There are two types of symbols: constant and nonconstant symbols.
145c145
< it can be specified explicitely:
---
> it can be specified explicitly:
162,163c162,163
< can be made a submenu of it. First the the previous (parent) symbol
must
< be part of the dependency list and then one of these two condititions
---
> can be made a submenu of it. First, the previous (parent) symbol must
> be part of the dependency list and then one of these two conditions
180c180
< visible when MODULES it's visible (the (empty) dependency of MODULES
is
---
> visible when MODULES isn't visible (the (empty) dependency of MODULES
is


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
