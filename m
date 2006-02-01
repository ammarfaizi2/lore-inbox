Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWBAPjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWBAPjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBAPjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:39:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13469 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161094AbWBAPjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:39:31 -0500
Date: Wed, 1 Feb 2006 16:39:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Juerg Billeter <j@bitron.ch>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, acahalan@gmail.com
Subject: [OT] Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
Message-ID: <Pine.LNX.4.61.0602011638150.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> 
 <43D7A7F4.nailDE92K7TJI@burner>  <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
  <43D7B1E7.nailDFJ9MUZ5G@burner>  <20060125230850.GA2137@merlin.emma.line.org>
  <43D8C04F.nailE1C2X9KNC@burner> <200  <43DDFBFF.nail16Z3N3C0M@burner> 
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>  <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Users like to be able to get a list of posible targets for a single protocol.
>> Nobody would ever think about trying to prevent people from getting a unified
>> view on the list possible hosts that talk TCP/IP. What cdrecord does with
>> -scanbus is nothing really different. 
>
>Well, please show me how to get the list of all possible hosts that talk
>TCP/IP and are directly or indirectly connected to my computer. As my
>computer is attached to the internet, the list would get pretty long...
>And even if only considering hosts in the local network, how do you get
>a unified view of all TCP/IP hosts conected to any of my two network
>adapters?
>
For direct connections (0 hop inbetween), spew pings around the local network,
look into the ARP table and try to TCP-connect to everyone listed.


Jan Engelhardt
-- 
