Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277866AbRJVGYo>; Mon, 22 Oct 2001 02:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277885AbRJVGYf>; Mon, 22 Oct 2001 02:24:35 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:25870 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S277866AbRJVGYW>;
	Mon, 22 Oct 2001 02:24:22 -0400
Date: Sun, 21 Oct 2001 23:24:52 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: nfs@lists.sourceforge.net
Cc: linux kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Has anyone run the Connectathon Testsuite recently?
Message-ID: <20011021232452.A2473@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked out kernel 2.4.9-6 from RedHat 7.1 updates. It failed the
Connectathon Testsuite against the Linux and none-Linux server. I
believe both NFS server and client are broken in 2.4.9-6. See

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54868

Now the question is how bad the current Linus/AC kernels are?


H.J.
