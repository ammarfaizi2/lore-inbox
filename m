Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318395AbSGYJHh>; Thu, 25 Jul 2002 05:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318396AbSGYJHh>; Thu, 25 Jul 2002 05:07:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12538 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318395AbSGYJHe>; Thu, 25 Jul 2002 05:07:34 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D3FBD21.2020607@evision.ag>
References: <20020724225826.GF25038@holomorphy.com>
	<1027559111.6456.34.camel@irongate.swansea.linux.org.uk>
	<20020725095448.B21541@ucw.cz> <3D3FB6C8.1070409@evision.ag>
	<20020725105538.B21927@ucw.cz>  <3D3FBD21.2020607@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 11:24:01 +0100
Message-Id: <1027592641.9489.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 09:56, Marcin Dalecki wrote:
> OK. Right. We have to touch this code anyway. Do you know first hand how
> to detect programmatically which configuration method is in charge? If 
> not I can look it up on my own..

Just copy the code from 2.4.19-rc3-ac3. Andre didnt write it so you
don't have to pretend it doesn't exist. I'll do this and test it since I
did the original fixes in 2.4. Expect a patch later today

