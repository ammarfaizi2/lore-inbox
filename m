Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWAFCZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWAFCZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWAFCZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:25:43 -0500
Received: from [218.25.172.144] ([218.25.172.144]:44304 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932600AbWAFCZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:25:41 -0500
Date: Fri, 6 Jan 2006 10:25:31 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: .gitignore files really necessary?
Message-ID: <20060106022531.GA7152@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see you keep updating .gitignore files. That would be a never ending
extra burden IMHO.  May I suggest we all use KBUILD_OUTPUT instead to keep
the source tree clean?  Or am I missing you?

	Coywolf
