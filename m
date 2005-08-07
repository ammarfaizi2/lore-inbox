Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752198AbVHGPoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbVHGPoT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 11:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbVHGPoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 11:44:19 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:58116 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752196AbVHGPoS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 11:44:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AEh2GllTs8M3MiZfbv4MCBaTiApIr9g24RkxT71Cl1kJFHU+qH1MdQxQT+Yysn+vAUOpfKFNcI9tPQZWA/mewkrydW8Yz9KCXFA3FHFb2ZTPgqfItQUBppeOQCXEwhxOBDYo+UB4U3+WVNGZ58Xrx5bLBciHpTj3fNlJfHTTi0A=
Message-ID: <1ed860e3050807084449b0daac@mail.gmail.com>
Date: Sun, 7 Aug 2005 11:44:16 -0400
From: Raymond Lai <raymond.kk.lai@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: any update on the pcmcia bug blocking Audigy2 notebook sound card driver development
Cc: linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-audio-dev@music.columbia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I remember there's a kernel pcmcia bug preventing the development for 
the Audigy2 pcmcia notebook sound card driver. 

See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix

Is there any new updates on the situation? Has the bug been fixed? or
anyone working on it?

Thanks,
Raymond
