Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311600AbSCTOlr>; Wed, 20 Mar 2002 09:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311601AbSCTOli>; Wed, 20 Mar 2002 09:41:38 -0500
Received: from firewall.ill.fr ([193.49.43.1]:25812 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S311600AbSCTOla>;
	Wed, 20 Mar 2002 09:41:30 -0500
Date: Wed, 20 Mar 2002 15:41:00 +0100
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: make rpm is not documented
Message-ID: <20020320154100.D21789@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
I think this is destinated to Alan but no CC to him because not really
so important( Alan wrote the make rpm stuff I think so ).

I couldn't find any documentation about make rpm ( grep -ri rpm in
/usr/src/linux/Documentation don't give anything related to that
feature).

Second stuff, make rpm don't work for me on suse's kernel.
Didn't yet watched what is the problem, but seems to be related with
EXTRAVERSION or something like this.
I will have further look and will try to say as much as I can with my
poor knowledge.
Thanks,
        Sam
