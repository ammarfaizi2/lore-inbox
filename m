Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSIKLM5>; Wed, 11 Sep 2002 07:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSIKLM5>; Wed, 11 Sep 2002 07:12:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:37132 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318718AbSIKLMz>;
	Wed, 11 Sep 2002 07:12:55 -0400
Date: Wed, 11 Sep 2002 13:17:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.5
Message-ID: <20020911131740.A17141@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <3D7E7D5F.F37D2D49@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D7E7D5F.F37D2D49@linux-m68k.org>; from zippel@linux-m68k.org on Wed, Sep 11, 2002 at 01:16:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

Made it apply clean to 2.5.34 (not 2.5.35).
Played a little with make xconfig.

make xconfig
- Do some selections
- Use mouse to select save icon on tool-bar
- File|Quit
->Save Configuration? Press yes
End result is an empty .config file

If I select No in the Save Configuration dialog everything is fine.

	Sam
