Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135639AbRD1VNr>; Sat, 28 Apr 2001 17:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135641AbRD1VNh>; Sat, 28 Apr 2001 17:13:37 -0400
Received: from relay.freedom.net ([207.107.115.209]:24836 "HELO relay")
	by vger.kernel.org with SMTP id <S135639AbRD1VNW>;
	Sat, 28 Apr 2001 17:13:22 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQEpwNcTUxd4bK4pRrC5SOfRXHLJcdvWT6IQsHkG1YlVK0uGIuvzE3aD
Date: Sat, 28 Apr 2001 15:13:04 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Common GUI Config for All Users
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010428211327Z135639-409+788@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking for the best way to give all users a common desktop, which comes from one source (for easy administration).

Found copying my /root/.gnome & .sawfish directories to a user home breaks the user's GUI, implying a symlink wouldn't work.  I am told .gnome & .sawfish can be copied to /etc/skel to give common look for new users, but need ongoing single-source control.  Besides, I tried copying root's config files to skel & it broke user GUIs.

Security is also a concern, so couldn't symlink into root anyway.

Recommendations welcomed, please.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914


