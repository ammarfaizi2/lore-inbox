Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSGVXdU>; Mon, 22 Jul 2002 19:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317828AbSGVXdU>; Mon, 22 Jul 2002 19:33:20 -0400
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:13835 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S317842AbSGVXdT>; Mon, 22 Jul 2002 19:33:19 -0400
Date: Tue, 23 Jul 2002 01:36:28 +0200
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: When does PF_PACKET, SOCK_DGRAM lose packets, and how do I notice that?
Message-ID: <20020723013628.A22160@torres.ka0.zugschlus.de>
References: <20020722110356.A16287@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020722110356.A16287@torres.ka0.zugschlus.de>; from mh+linux-kernel@zugschlus.de on Mon, Jul 22, 2002 at 11:03:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 11:03:56AM +0200, Marc Haber wrote:
> While testing in a lab setup, this works fine, and the data accounted
> for is accurate. However, when I put the program on a loaded system,
> it seems to lose data. Here is a description of my tests:
> 
> Diesen Code haben wir in eine Veränderung des netacctd eingebracht,
> und das hat im Labor und im Feldtest auch problemlos funktioniert.
> Seit einigen Tagen läuft der modifizierte netacct auf einem Router,
> der unsere gesamte Netzlast abbekommt, und in diesem Kontext verliert
> diese Konstruktion leider Daten:

The german paragraph mistakenly stayed in from a draft of this
article. Non-German speakers don't need to read it, as it is the
german version of the quoted english paragraph.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
